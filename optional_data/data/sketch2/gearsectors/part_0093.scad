$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[65.35, 0], [66.351, 2.756], [67.25, 5.546], [74.816, 6.592], [76.207, 12.815], [69.806, 16.982], [70.181, 19.89], [70.449, 22.81], [77.606, 25.481], [77.606, 31.857], [70.449, 34.528], [70.181, 37.448], [69.806, 40.356], [76.207, 44.523], [74.816, 50.746], [67.25, 51.792], [66.351, 54.582], [65.35, 57.338], [0, 32.253], [0.175, 31.759], [0.323, 31.257], [0.445, 30.748], [0.541, 30.233], [0.609, 29.714], [0.65, 29.192], [0.664, 28.669], [0.65, 28.146], [0.609, 27.624], [0.541, 27.105], [0.445, 26.59], [0.323, 26.081], [0.175, 25.579], [0, 25.085]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
