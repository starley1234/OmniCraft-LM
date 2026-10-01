$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[35.476, 0], [36.101, 1.722], [36.663, 3.466], [41.997, 3.961], [42.876, 7.895], [38.261, 10.614], [38.495, 12.431], [38.663, 14.256], [43.76, 15.903], [43.76, 19.933], [38.663, 21.58], [38.495, 23.405], [38.261, 25.222], [42.876, 27.941], [41.997, 31.875], [36.663, 32.37], [36.101, 34.114], [35.476, 35.836], [0, 22.218], [0.21, 21.626], [0.388, 21.024], [0.535, 20.413], [0.649, 19.795], [0.731, 19.172], [0.781, 18.546], [0.797, 17.918], [0.781, 17.29], [0.731, 16.664], [0.649, 16.041], [0.535, 15.423], [0.388, 14.812], [0.21, 14.21], [0, 13.618]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
