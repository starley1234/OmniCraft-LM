$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[63.483, 0], [64.484, 2.756], [65.383, 5.546], [73.917, 6.338], [75.323, 12.632], [67.939, 16.982], [68.314, 19.89], [68.582, 22.81], [76.738, 25.444], [76.738, 31.894], [68.582, 34.528], [68.314, 37.448], [67.939, 40.356], [75.323, 44.706], [73.917, 51], [65.383, 51.792], [64.484, 54.582], [63.483, 57.338], [0, 32.969], [0.21, 32.377], [0.388, 31.775], [0.535, 31.164], [0.649, 30.546], [0.731, 29.923], [0.781, 29.297], [0.797, 28.669], [0.781, 28.041], [0.731, 27.415], [0.649, 26.792], [0.535, 26.174], [0.388, 25.563], [0.21, 24.961], [0, 24.369]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
