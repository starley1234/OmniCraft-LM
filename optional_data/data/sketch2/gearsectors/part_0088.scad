$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[65.35, 0], [66.662, 3.682], [67.792, 7.425], [74.706, 10.422], [76.201, 19.754], [70.568, 24.761], [70.664, 28.669], [70.568, 32.577], [76.201, 37.584], [74.706, 46.916], [67.792, 49.913], [66.662, 53.656], [65.35, 57.338], [0, 32.253], [0.175, 31.759], [0.323, 31.257], [0.445, 30.748], [0.541, 30.233], [0.609, 29.714], [0.65, 29.192], [0.664, 28.669], [0.65, 28.146], [0.609, 27.624], [0.541, 27.105], [0.445, 26.59], [0.323, 26.081], [0.175, 25.579], [0, 25.085]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
