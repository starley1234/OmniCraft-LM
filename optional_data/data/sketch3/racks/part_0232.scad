$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 10 teeth, pitch 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 10;               // number of teeth
pitch = 10;               // tooth pitch, X
root_w = 7;               // tooth width at the root
tip_w = 3.5;              // tooth width at the tip
base_h = 10;              // rack body height, Y
tooth_h = 6;              // tooth height above the body
plate_t = 15;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [100, 0], [100, 10], [98.5, 10], [96.75, 16], [93.25, 16], [91.5, 10], [88.5, 10], [86.75, 16], [83.25, 16], [81.5, 10], [78.5, 10], [76.75, 16], [73.25, 16], [71.5, 10], [68.5, 10], [66.75, 16], [63.25, 16], [61.5, 10], [58.5, 10], [56.75, 16], [53.25, 16], [51.5, 10], [48.5, 10], [46.75, 16], [43.25, 16], [41.5, 10], [38.5, 10], [36.75, 16], [33.25, 16], [31.5, 10], [28.5, 10], [26.75, 16], [23.25, 16], [21.5, 10], [18.5, 10], [16.75, 16], [13.25, 16], [11.5, 10], [8.5, 10], [6.75, 16], [3.25, 16], [1.5, 10], [0, 10]];  // primary outline, 44 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
