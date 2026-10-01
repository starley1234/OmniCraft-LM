$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.714, 0], [35.44, 1.715], [36.101, 3.455], [36.697, 5.219], [43.374, 6.789], [44.643, 13.706], [38.959, 17.546], [39.028, 19.406], [39.028, 21.268], [38.959, 23.128], [44.643, 26.968], [43.374, 33.885], [36.697, 35.455], [36.101, 37.219], [35.44, 38.959], [34.714, 40.674], [0, 25.218], [0.24, 24.637], [0.45, 24.045], [0.628, 23.443], [0.775, 22.832], [0.889, 22.214], [0.971, 21.591], [1.021, 20.965], [1.037, 20.337], [1.021, 19.709], [0.971, 19.083], [0.889, 18.46], [0.775, 17.842], [0.628, 17.231], [0.45, 16.629], [0.24, 16.037], [0, 15.456]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
