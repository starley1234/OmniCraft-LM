$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 3;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [80, 0], [80, 10], [78.5, 10], [76.75, 13], [73.25, 13], [71.5, 10], [68.5, 10], [66.75, 13], [63.25, 13], [61.5, 10], [58.5, 10], [56.75, 13], [53.25, 13], [51.5, 10], [48.5, 10], [46.75, 13], [43.25, 13], [41.5, 10], [38.5, 10], [36.75, 13], [33.25, 13], [31.5, 10], [28.5, 10], [26.75, 13], [23.25, 13], [21.5, 10], [18.5, 10], [16.75, 13], [13.25, 13], [11.5, 10], [8.5, 10], [6.75, 13], [3.25, 13], [1.5, 10], [0, 10]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
