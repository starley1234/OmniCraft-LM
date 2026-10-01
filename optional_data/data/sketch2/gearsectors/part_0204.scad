$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[63.483, 0], [64.292, 2.201], [65.035, 4.426], [70.478, 5.147], [71.647, 9.671], [67.235, 12.939], [67.663, 15.245], [68.022, 17.563], [73.266, 19.187], [73.66, 23.843], [68.763, 26.324], [68.797, 28.669], [68.763, 31.014], [73.66, 33.495], [73.266, 38.151], [68.022, 39.775], [67.663, 42.093], [67.235, 44.399], [71.647, 47.667], [70.478, 52.191], [65.035, 52.912], [64.292, 55.137], [63.483, 57.338], [0, 32.969], [0.21, 32.377], [0.388, 31.775], [0.535, 31.164], [0.649, 30.546], [0.731, 29.923], [0.781, 29.297], [0.797, 28.669], [0.781, 28.041], [0.731, 27.415], [0.649, 26.792], [0.535, 26.174], [0.388, 25.563], [0.21, 24.961], [0, 24.369]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
