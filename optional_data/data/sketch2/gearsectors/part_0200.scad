$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[50.23, 0], [51.978, 3.221], [53.556, 6.528], [62.427, 7.047], [64.95, 14.812], [58.078, 20.446], [58.746, 24.05], [59.225, 27.683], [67.501, 30.918], [67.501, 39.082], [59.225, 42.317], [58.746, 45.95], [58.078, 49.554], [64.95, 55.188], [62.427, 62.953], [53.556, 63.472], [51.978, 66.779], [50.23, 70], [0, 41], [0.3, 40.448], [0.571, 39.881], [0.811, 39.3], [1.021, 38.708], [1.199, 38.106], [1.346, 37.495], [1.46, 36.877], [1.542, 36.254], [1.592, 35.628], [1.608, 35], [1.592, 34.372], [1.542, 33.746], [1.46, 33.123], [1.346, 32.505], [1.199, 31.894], [1.021, 31.292], [0.811, 30.7], [0.571, 30.119], [0.3, 29.552], [0, 29]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
