$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 80;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[63.949, 0], [64.998, 2.467], [65.964, 4.968], [71.538, 5.765], [73.06, 10.883], [68.827, 14.597], [69.384, 17.219], [69.854, 19.859], [75.172, 21.709], [75.686, 27.024], [70.82, 29.859], [70.865, 32.539], [70.82, 35.219], [75.686, 38.054], [75.172, 43.369], [69.854, 45.219], [69.384, 47.859], [68.827, 50.481], [73.06, 54.195], [71.538, 59.313], [65.964, 60.11], [64.998, 62.611], [63.949, 65.078], [0, 36.606], [0.201, 36.123], [0.376, 35.629], [0.524, 35.127], [0.646, 34.618], [0.742, 34.103], [0.81, 33.584], [0.851, 33.062], [0.865, 32.539], [0.851, 32.016], [0.81, 31.494], [0.742, 30.975], [0.646, 30.46], [0.524, 29.951], [0.376, 29.449], [0.201, 28.955], [0, 28.472]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
