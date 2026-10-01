$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[36.542, 0], [37.268, 1.715], [37.929, 3.455], [38.525, 5.219], [45.202, 6.789], [46.471, 13.706], [40.787, 17.546], [40.856, 19.406], [40.856, 21.268], [40.787, 23.128], [46.471, 26.968], [45.202, 33.885], [38.525, 35.455], [37.929, 37.219], [37.268, 38.959], [36.542, 40.674], [0, 24.404], [0.201, 23.921], [0.376, 23.427], [0.524, 22.925], [0.646, 22.416], [0.742, 21.901], [0.81, 21.382], [0.851, 20.86], [0.865, 20.337], [0.851, 19.814], [0.81, 19.292], [0.742, 18.773], [0.646, 18.258], [0.524, 17.749], [0.376, 17.247], [0.201, 16.753], [0, 16.27]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
