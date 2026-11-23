# Load all structs and functions from your core file
include("satellite_simulation.jl")

lekki_gs = GroundStation("Lekki, Nigeria", 6.25, 3.28, 10.0, 10.0)   
# Define ground station and satellite
brussels_gs = GroundStation("Brussels HQ", 50.8503, 4.3517, 100.0, 10.0)
line1 = "1 44713U 19074A   26050.50000000  .00001234  00000-0  12345-4 0  9997"
line2 = "2 44713  53.0500 120.0000 0001000 000.0000 360.0000 15.12345678 12349"
sat = init_satellite("Starlink-Sample", line1, line2)

# Execution loop
# Use a specific DateTime or current time
start_time = DateTime(2026, 6, 1, 12, 0, 0)

for t in 0:10:7200
    current_time = start_time + Second(t)
    
    update_orbit!(sat, current_time)
    visible, el, range_m = check_visibility(sat, brussels_gs, current_time)
    
    if visible
        println("Time +$(t)s: Satellite IS VISIBLE! Elevation: $(round(el, digits=2))°")
    end
end

