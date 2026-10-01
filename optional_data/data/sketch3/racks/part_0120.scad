$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 8;                // tooth pitch, X
root_w = 5.6;             // tooth width at the root
tip_w = 2.8;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [48, 0], [48, 12], [46.8, 12], [45.4, 15], [42.6, 15], [41.2, 12], [38.8, 12], [37.4, 15], [34.6, 15], [33.2, 12], [30.8, 12], [29.4, 15], [26.6, 15], [25.2, 12], [22.8, 12], [21.4, 15], [18.6, 15], [17.2, 12], [14.8, 12], [13.4, 15], [10.6, 15], [9.2, 12], [6.8, 12], [5.4, 15], [2.6, 15], [1.2, 12], [0, 12]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
