include("satellite_simulation.jl")
include("data_fetcher.jl")


celestrak_starlink_url = "https://celestrak.org/NORAD/elements/gp.php?GROUP=starlink&FORMAT=tle"

# Step A: Inspect the full altitude histogram first (set n_satellites=nothing)
res_full = load_and_filter_shell(
    celestrak_starlink_url;
    target_alt_km = 550.0,
    alt_tol_km = 15.0,
    target_inc_deg = 53.0,
    inc_tol_deg = 1.0,
    show_histogram = true,
)
@show length(res_full.all_tles) length(res_full.filtered_tles)

# Step B: Pull a diluted subset of 100 satellites for a shell dilution run
res_diluted = load_and_filter_shell(
    celestrak_starlink_url;
    target_alt_km = 550.0,
    alt_tol_km = 15.0,
    target_inc_deg = 53.0,
    inc_tol_deg = 1.0,
    n_satellites = 100,
    sampling_mode = :first,
    show_histogram = false,
)