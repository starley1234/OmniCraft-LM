$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[54.148, 0], [55.023, 2.412], [55.809, 4.854], [64.244, 5.293], [65.491, 10.872], [58.046, 14.86], [58.374, 17.405], [58.609, 19.959], [66.745, 22.228], [66.745, 27.944], [58.609, 30.213], [58.374, 32.767], [58.046, 35.312], [65.491, 39.3], [64.244, 44.879], [55.809, 45.318], [55.023, 47.76], [54.148, 50.172], [0, 29.386], [0.21, 28.794], [0.388, 28.192], [0.535, 27.581], [0.649, 26.963], [0.731, 26.34], [0.781, 25.714], [0.797, 25.086], [0.781, 24.458], [0.731, 23.832], [0.649, 23.209], [0.535, 22.591], [0.388, 21.98], [0.21, 21.378], [0, 20.786]];  // primary outline, 33 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
