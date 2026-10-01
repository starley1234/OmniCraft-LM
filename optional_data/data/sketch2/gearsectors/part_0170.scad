$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[62.121, 0], [63.17, 2.467], [64.136, 4.968], [71.608, 5.135], [73.166, 10.374], [66.999, 14.597], [67.556, 17.219], [68.026, 19.859], [75.328, 21.454], [75.854, 26.894], [68.992, 29.859], [69.037, 32.539], [68.992, 35.219], [75.854, 38.184], [75.328, 43.624], [68.026, 45.219], [67.556, 47.859], [66.999, 50.481], [73.166, 54.704], [71.608, 59.943], [64.136, 60.11], [63.17, 62.611], [62.121, 65.078], [0, 37.42], [0.24, 36.839], [0.45, 36.247], [0.628, 35.645], [0.775, 35.034], [0.889, 34.416], [0.971, 33.793], [1.021, 33.167], [1.037, 32.539], [1.021, 31.911], [0.971, 31.285], [0.889, 30.662], [0.775, 30.044], [0.628, 29.433], [0.45, 28.831], [0.24, 28.239], [0, 27.658]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
