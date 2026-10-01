$fn = 32;

// ----------------------------------------------------------------------
// Gear rack: 8 teeth, pitch 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
teeth = 8;                // number of teeth
pitch = 6;                // tooth pitch, X
root_w = 4.2;             // tooth width at the root
tip_w = 2.1;              // tooth width at the tip
base_h = 12;              // rack body height, Y
tooth_h = 4;              // tooth height above the body
plate_t = 12;             // rack width, Z (extrusion height)

rack_l = teeth * pitch;  // overall length
total_h = base_h + tooth_h;  // overall height

profile = [[0, 0], [48, 0], [48, 12], [47.1, 12], [46.05, 16], [43.95, 16], [42.9, 12], [41.1, 12], [40.05, 16], [37.95, 16], [36.9, 12], [35.1, 12], [34.05, 16], [31.95, 16], [30.9, 12], [29.1, 12], [28.05, 16], [25.95, 16], [24.9, 12], [23.1, 12], [22.05, 16], [19.95, 16], [18.9, 12], [17.1, 12], [16.05, 16], [13.95, 16], [12.9, 12], [11.1, 12], [10.05, 16], [7.95, 16], [6.9, 12], [5.1, 12], [4.05, 16], [1.95, 16], [0.9, 12], [0, 12]];  // primary outline, 36 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
