$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 12;               // tooth pitch, X
root_w = 8.4;             // tooth width at the root
tip_w = 4.2;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 6;              // tooth height above the body
plate_t = 10;             // rack width, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [72, 0], [72, 10], [70.2, 10], [68.1, 16], [63.9, 16], [61.8, 10], [58.2, 10], [56.1, 16], [51.9, 16], [49.8, 10], [46.2, 10], [44.1, 16], [39.9, 16], [37.8, 10], [34.2, 10], [32.1, 16], [27.9, 16], [25.8, 10], [22.2, 10], [20.1, 16], [15.9, 16], [13.8, 10], [10.2, 10], [8.1, 16], [3.9, 16], [1.8, 10], [0, 10]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
