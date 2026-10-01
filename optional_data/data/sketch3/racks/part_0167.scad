$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 12 teeth, pitch 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 12;               // number of teeth
pitch = 6;                // tooth pitch, X
root_w = 4.2;             // tooth width at the root
tip_w = 2.1;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [72, 0], [72, 10], [71.1, 10], [70.05, 13], [67.95, 13], [66.9, 10], [65.1, 10], [64.05, 13], [61.95, 13], [60.9, 10], [59.1, 10], [58.05, 13], [55.95, 13], [54.9, 10], [53.1, 10], [52.05, 13], [49.95, 13], [48.9, 10], [47.1, 10], [46.05, 13], [43.95, 13], [42.9, 10], [41.1, 10], [40.05, 13], [37.95, 13], [36.9, 10], [35.1, 10], [34.05, 13], [31.95, 13], [30.9, 10], [29.1, 10], [28.05, 13], [25.95, 13], [24.9, 10], [23.1, 10], [22.05, 13], [19.95, 13], [18.9, 10], [17.1, 10], [16.05, 13], [13.95, 13], [12.9, 10], [11.1, 10], [10.05, 13], [7.95, 13], [6.9, 10], [5.1, 10], [4.05, 13], [1.95, 13], [0.9, 10], [0, 10]];  // primary outline, 52 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
