$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[62.77, 0], [63.738, 3.207], [64.571, 6.453], [73.211, 8.684], [74.337, 16.898], [66.615, 21.371], [66.685, 24.721], [66.615, 28.071], [74.337, 32.544], [73.211, 40.758], [64.571, 42.989], [63.738, 46.235], [62.77, 49.442], [0, 29.047], [0.208, 28.344], [0.379, 27.632], [0.513, 26.911], [0.608, 26.184], [0.666, 25.454], [0.685, 24.721], [0.666, 23.988], [0.608, 23.258], [0.513, 22.531], [0.379, 21.81], [0.208, 21.098], [0, 20.395]];  // primary outline, 26 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
