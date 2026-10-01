$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[45.65, 0], [46.205, 1.802], [46.702, 3.62], [53.973, 3.925], [54.762, 8.06], [48.114, 11.021], [48.321, 12.895], [48.469, 14.774], [55.554, 16.436], [55.554, 20.646], [48.469, 22.308], [48.321, 24.187], [48.114, 26.061], [54.762, 29.022], [53.973, 33.157], [46.702, 33.462], [46.205, 35.28], [45.65, 37.082], [0, 22.249], [0.178, 21.647], [0.325, 21.036], [0.439, 20.418], [0.521, 19.795], [0.571, 19.169], [0.587, 18.541], [0.571, 17.913], [0.521, 17.287], [0.439, 16.664], [0.325, 16.046], [0.178, 15.435], [0, 14.833]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
