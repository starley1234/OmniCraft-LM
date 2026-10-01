$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[49.896, 0], [51.173, 2.639], [52.337, 5.33], [53.388, 8.067], [60.673, 11.15], [62.85, 21.662], [57.388, 27.384], [57.511, 30.313], [57.511, 33.245], [57.388, 36.174], [62.85, 41.896], [60.673, 52.408], [53.388, 55.491], [52.337, 58.228], [51.173, 60.919], [49.896, 63.558], [0, 38.135], [0.316, 37.473], [0.596, 36.796], [0.841, 36.105], [1.049, 35.402], [1.22, 34.69], [1.354, 33.969], [1.449, 33.242], [1.507, 32.512], [1.526, 31.779], [1.507, 31.046], [1.449, 30.316], [1.354, 29.589], [1.22, 28.868], [1.049, 28.156], [0.841, 27.453], [0.596, 26.762], [0.316, 26.085], [0, 25.423]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
