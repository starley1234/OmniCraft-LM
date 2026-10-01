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
tooth_h = 5;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [60, 0], [60, 10], [58.5, 10], [56.75, 15], [53.25, 15], [51.5, 10], [48.5, 10], [46.75, 15], [43.25, 15], [41.5, 10], [38.5, 10], [36.75, 15], [33.25, 15], [31.5, 10], [28.5, 10], [26.75, 15], [23.25, 15], [21.5, 10], [18.5, 10], [16.75, 15], [13.25, 15], [11.5, 10], [8.5, 10], [6.75, 15], [3.25, 15], [1.5, 10], [0, 10]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
