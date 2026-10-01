$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[36.542, 0], [37.354, 1.931], [38.084, 3.894], [43.518, 4.44], [44.663, 8.902], [40.165, 11.999], [40.471, 14.07], [40.69, 16.153], [45.817, 18.034], [45.817, 22.64], [40.69, 24.521], [40.471, 26.604], [40.165, 28.675], [44.663, 31.772], [43.518, 36.234], [38.084, 36.78], [37.354, 38.743], [36.542, 40.674], [0, 24.404], [0.201, 23.921], [0.376, 23.427], [0.524, 22.925], [0.646, 22.416], [0.742, 21.901], [0.81, 21.382], [0.851, 20.86], [0.865, 20.337], [0.851, 19.814], [0.81, 19.292], [0.742, 18.773], [0.646, 18.258], [0.524, 17.749], [0.376, 17.247], [0.201, 16.753], [0, 16.27]];  // primary outline, 35 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
