$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[35.64, 0], [36.464, 1.696], [37.224, 3.421], [44.426, 2.594], [45.713, 6.411], [39.48, 10.113], [39.92, 11.946], [40.29, 13.794], [47.502, 14.536], [47.938, 18.54], [41.054, 20.815], [41.09, 22.7], [41.054, 24.585], [47.938, 26.86], [47.502, 30.864], [40.29, 31.606], [39.92, 33.454], [39.48, 35.287], [45.713, 38.989], [44.426, 42.806], [37.224, 41.979], [36.464, 43.704], [35.64, 45.4], [0, 27.24], [0.225, 26.767], [0.426, 26.284], [0.601, 25.79], [0.749, 25.288], [0.871, 24.779], [0.967, 24.264], [1.035, 23.745], [1.076, 23.223], [1.09, 22.7], [1.076, 22.177], [1.035, 21.655], [0.967, 21.136], [0.871, 20.621], [0.749, 20.112], [0.601, 19.61], [0.426, 19.116], [0.225, 18.633], [0, 18.16]];  // primary outline, 42 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
