$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 48 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 48;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 14;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[32.887, 0], [33.613, 1.715], [34.274, 3.455], [34.87, 5.219], [41.547, 6.789], [42.816, 13.706], [37.132, 17.546], [37.201, 19.406], [37.201, 21.268], [37.132, 23.128], [42.816, 26.968], [41.547, 33.885], [34.87, 35.455], [34.274, 37.219], [33.613, 38.959], [32.887, 40.674], [0, 26.031], [0.28, 25.354], [0.525, 24.663], [0.733, 23.96], [0.904, 23.248], [1.038, 22.527], [1.133, 21.8], [1.191, 21.07], [1.21, 20.337], [1.191, 19.604], [1.133, 18.874], [1.038, 18.147], [0.904, 17.426], [0.733, 16.714], [0.525, 16.011], [0.28, 15.32], [0, 14.643]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
