$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 36 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 36;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 10;             // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[36.14, 0], [36.856, 2.409], [44.92, 1.646], [45.508, 4.315], [37.869, 7.009], [38.231, 9.496], [46.321, 9.902], [46.518, 12.628], [38.571, 14.194], [38.571, 16.708], [46.518, 18.274], [46.321, 21], [38.231, 21.406], [37.869, 23.893], [45.508, 26.587], [44.92, 29.256], [36.856, 28.493], [36.14, 30.902], [0, 19.159], [0.178, 18.557], [0.325, 17.946], [0.439, 17.328], [0.521, 16.705], [0.571, 16.079], [0.587, 15.451], [0.571, 14.823], [0.521, 14.197], [0.439, 13.574], [0.325, 12.956], [0.178, 12.345], [0, 11.743]];  // primary outline, 31 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
