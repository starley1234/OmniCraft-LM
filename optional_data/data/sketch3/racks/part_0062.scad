$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [60, 0], [60, 10], [58.5, 10], [56.75, 14], [53.25, 14], [51.5, 10], [48.5, 10], [46.75, 14], [43.25, 14], [41.5, 10], [38.5, 10], [36.75, 14], [33.25, 14], [31.5, 10], [28.5, 10], [26.75, 14], [23.25, 14], [21.5, 10], [18.5, 10], [16.75, 14], [13.25, 14], [11.5, 10], [8.5, 10], [6.75, 14], [3.25, 14], [1.5, 10], [0, 10]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
