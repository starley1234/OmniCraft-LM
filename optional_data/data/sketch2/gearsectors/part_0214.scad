$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.714, 0], [35.526, 1.931], [36.256, 3.894], [44.562, 3.573], [45.77, 8.278], [38.337, 11.999], [38.643, 14.07], [38.862, 16.153], [46.986, 17.908], [46.986, 22.766], [38.862, 24.521], [38.643, 26.604], [38.337, 28.675], [45.77, 32.396], [44.562, 37.101], [36.256, 36.78], [35.526, 38.743], [34.714, 40.674], [0, 25.218], [0.24, 24.637], [0.45, 24.045], [0.628, 23.443], [0.775, 22.832], [0.889, 22.214], [0.971, 21.591], [1.021, 20.965], [1.037, 20.337], [1.021, 19.709], [0.971, 19.083], [0.889, 18.46], [0.775, 17.842], [0.628, 17.231], [0.45, 16.629], [0.24, 16.037], [0, 15.456]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
