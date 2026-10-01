$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[45.678, 0], [46.465, 1.85], [47.189, 3.725], [53.505, 3.615], [54.687, 7.589], [49.337, 10.948], [49.755, 12.914], [50.107, 14.894], [56.327, 15.995], [56.726, 20.122], [50.831, 22.394], [50.865, 24.404], [50.831, 26.414], [56.726, 28.686], [56.327, 32.813], [50.107, 33.914], [49.755, 35.894], [49.337, 37.86], [54.687, 41.219], [53.505, 45.193], [47.189, 45.083], [46.465, 46.958], [45.678, 48.808], [0, 28.471], [0.201, 27.988], [0.376, 27.494], [0.524, 26.992], [0.646, 26.483], [0.742, 25.968], [0.81, 25.449], [0.851, 24.927], [0.865, 24.404], [0.851, 23.881], [0.81, 23.359], [0.742, 22.84], [0.646, 22.325], [0.524, 21.816], [0.376, 21.314], [0.201, 20.82], [0, 20.337]];  // primary outline, 40 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
