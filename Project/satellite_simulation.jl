using SatelliteToolbox
using Dates

struct GroundStation
    name::String
    lat::Float64
    lon::Float64
    alt::Float64
    min_elevation::Float64
end

mutable struct Satellite
    name::String
    tle::TLE
    position_ecef::Vector{Float64}
end

#Plus vraiment besoin de cette fonction, mais je la laisse pour l'instant
function init_satellite(name::String, line1::String, line2::String)
    tle = read_tle(line1, line2; name)
    return Satellite(name, tle, zeros(3))
end

function update_orbit!(sat::Satellite, current_time::DateTime)
    tle_epoch = SatelliteToolbox.tle_epoch(DateTime, sat.tle)
    minutes_since_epoch = Dates.value(current_time - tle_epoch) / 60_000
    position_teme, _, _ = sgp4(minutes_since_epoch, sat.tle)
    rotation_to_pef = r_eci_to_ecef(TEME(), PEF(), date_to_jd(current_time))
    sat.position_ecef = collect(1000 .* (rotation_to_pef * position_teme))
    return sat.position_ecef
end

function check_visibility(sat::Satellite, gs::GroundStation, current_time::DateTime)
    lat = deg2rad(gs.lat)
    lon = deg2rad(gs.lon)
    ned = ecef_to_ned(sat.position_ecef, lat, lon, gs.alt; translate=true)
    elevation = rad2deg(atan(-ned[3], hypot(ned[1], ned[2])))
    slant_range = sqrt(sum(abs2, ned))
    is_visible = elevation >= gs.min_elevation
    return is_visible, elevation, slant_range
end

