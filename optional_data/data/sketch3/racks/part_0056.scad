$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 8;                // tooth pitch, X
root_w = 5.6;             // tooth width at the root
tip_w = 2.8;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [48, 0], [48, 10], [46.8, 10], [45.4, 14], [42.6, 14], [41.2, 10], [38.8, 10], [37.4, 14], [34.6, 14], [33.2, 10], [30.8, 10], [29.4, 14], [26.6, 14], [25.2, 10], [22.8, 10], [21.4, 14], [18.6, 14], [17.2, 10], [14.8, 10], [13.4, 14], [10.6, 14], [9.2, 10], [6.8, 10], [5.4, 14], [2.6, 14], [1.2, 10], [0, 10]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
