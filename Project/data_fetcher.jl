using Downloads
using Random
using SatelliteToolbox
using Dates
using Plots

const MU_EARTH_KM3_S2 = 398_600.4418
const R_EARTH_MEAN_KM = 6_371.0

"""
Approximate orbital altitude [km] from TLE mean motion [rev/day] via Kepler's 3rd law.
"""
function tle_altitude_km(tle::TLE)
    rev_per_day = tle.mean_motion
    period_s = 86_400.0 / rev_per_day
    semi_major_axis_km = cbrt(MU_EARTH_KM3_S2 * (period_s / (2 * π))^2)
    return semi_major_axis_km - R_EARTH_MEAN_KM
end

"""
Fetch TLEs from a  local file path, optionally plot an
altitude histogram to identify shells, filter by altitude/inclination/eccentricity,
and select `n_satellites` for dilution experiments.
"""
function load_and_filter_shell(
    source::AbstractString;
    target_alt_km::Float64,
    alt_tol_km::Float64 = 20.0,
    target_inc_deg::Union{Nothing, Float64} = nothing,
    inc_tol_deg::Float64 = 1.0,
    max_eccentricity::Float64 = 0.02,
    n_satellites::Union{Nothing, Int} = nothing,
    sampling_mode::Symbol = :first,
    rng_seed::Int = 42,
    show_histogram::Bool = true,
    hist_bins::Int = 40,
)
    # 1. Fetch from URL or read local file
    raw_text =read(source, String)
        
    tles = read_tles(raw_text)
    isempty(tles) && error("No valid TLEs parsed from source: $source")

    altitudes = [tle_altitude_km(t) for t in tles]
    inclinations = [t.inclination for t in tles]

    # 2. Optional histogram to inspect orbital shells before/during filtering
    plt = nothing
    if show_histogram
        plt = histogram(
            altitudes;
            bins = hist_bins,
            xlabel = "Approximate Altitude (km)",
            ylabel = "Satellite Count",
            title = "TLE Altitude Distribution (N = $(length(tles)))",
            legend = false,
        )
        vline!(plt, [target_alt_km]; linestyle = :dash, linewidth = 2)
        display(plt)
    end

    # 3. Filter satellites matching shell criteria
    filtered = TLE[]
    for (tle, alt, inc) in zip(tles, altitudes, inclinations)
        alt_ok = abs(alt - target_alt_km) <= alt_tol_km
        inc_ok = isnothing(target_inc_deg) || (abs(inc - target_inc_deg) <= inc_tol_deg)
        ecc_ok = tle.eccentricity <= max_eccentricity
        if alt_ok && inc_ok && ecc_ok
            push!(filtered, tle)
        end
    end

    isempty(filtered) && error(
        "0 satellites matched target_alt_km=$(target_alt_km) ± $(alt_tol_km) km, " *
        "target_inc_deg=$(target_inc_deg), max_eccentricity=$(max_eccentricity)."
    )

    # 4. Select requested number of satellites (for dilution tests)
    selected = if isnothing(n_satellites) || n_satellites >= length(filtered)
        filtered
    elseif n_satellites <= 0
        TLE[]
    elseif sampling_mode == :first
        filtered[1:n_satellites]
    elseif sampling_mode == :stride
        idxs = round.(Int, range(1, length(filtered); length = n_satellites))
        filtered[unique(idxs)]
    elseif sampling_mode == :random
        rng = MersenneTwister(rng_seed)
        idxs = randperm(rng, length(filtered))[1:n_satellites]
        filtered[idxs]
    else
        error("Unknown sampling_mode: $sampling_mode. Use :first, :stride, or :random.")
    end

    # Convert selected TLEs into your `Satellite` structs
    sats = [Satellite(tle.name, tle, zeros(Float64, 3)) for tle in selected]

    return (
        satellites = sats,
        filtered_tles = filtered,
        all_tles = tles,
        altitudes = altitudes,
        inclinations = inclinations,
        plot = plt,
    )
end