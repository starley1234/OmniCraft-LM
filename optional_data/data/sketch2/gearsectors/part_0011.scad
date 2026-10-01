$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[44.812, 0], [45.795, 2.762], [46.643, 5.569], [53.294, 7.498], [54.441, 14.66], [48.725, 18.571], [48.797, 21.502], [48.725, 24.433], [54.441, 28.344], [53.294, 35.506], [46.643, 37.435], [45.795, 40.242], [44.812, 43.004], [0, 25.802], [0.21, 25.21], [0.388, 24.608], [0.535, 23.997], [0.649, 23.379], [0.731, 22.756], [0.781, 22.13], [0.797, 21.502], [0.781, 20.874], [0.731, 20.248], [0.649, 19.625], [0.535, 19.007], [0.388, 18.396], [0.21, 17.794], [0, 17.202]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
