$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 6 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 6;                // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 8;              // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [60, 0], [60, 12], [58.5, 12], [56.75, 16], [53.25, 16], [51.5, 12], [48.5, 12], [46.75, 16], [43.25, 16], [41.5, 12], [38.5, 12], [36.75, 16], [33.25, 16], [31.5, 12], [28.5, 12], [26.75, 16], [23.25, 16], [21.5, 12], [18.5, 12], [16.75, 16], [13.25, 16], [11.5, 12], [8.5, 12], [6.75, 16], [3.25, 16], [1.5, 12], [0, 12]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
