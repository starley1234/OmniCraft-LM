$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 60 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 60;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[34.641, 0], [35.89, 2.3], [37.017, 4.663], [43.621, 4.931], [45.432, 10.506], [40.247, 14.604], [40.724, 17.178], [41.066, 19.774], [47.263, 22.069], [47.263, 27.931], [41.066, 30.226], [40.724, 32.822], [40.247, 35.396], [45.432, 39.494], [43.621, 45.069], [37.017, 45.337], [35.89, 47.7], [34.641, 50], [0, 30], [0.25, 29.54], [0.475, 29.067], [0.676, 28.584], [0.851, 28.09], [0.999, 27.588], [1.121, 27.079], [1.217, 26.564], [1.285, 26.045], [1.326, 25.523], [1.34, 25], [1.326, 24.477], [1.285, 23.955], [1.217, 23.436], [1.121, 22.921], [0.999, 22.412], [0.851, 21.91], [0.676, 21.416], [0.475, 20.933], [0.25, 20.46], [0, 20]];  // primary outline, 39 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
