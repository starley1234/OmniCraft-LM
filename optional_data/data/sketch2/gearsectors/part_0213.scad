$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 4 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 8;              // tooth height over the root circle
teeth = 4;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 8;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[37.343, 0], [37.848, 1.376], [38.313, 2.766], [46.399, 1.868], [47.197, 4.955], [39.688, 8.086], [39.955, 9.528], [40.18, 10.977], [48.302, 11.448], [48.57, 14.625], [40.643, 16.452], [40.664, 17.918], [40.643, 19.384], [48.57, 21.211], [48.302, 24.388], [40.18, 24.859], [39.955, 26.308], [39.688, 27.75], [47.197, 30.881], [46.399, 33.968], [38.313, 33.07], [37.848, 34.46], [37.343, 35.836], [0, 21.502], [0.175, 21.008], [0.323, 20.506], [0.445, 19.997], [0.541, 19.482], [0.609, 18.963], [0.65, 18.441], [0.664, 17.918], [0.65, 17.395], [0.609, 16.873], [0.541, 16.354], [0.445, 15.839], [0.323, 15.33], [0.175, 14.828], [0, 14.334]];  // primary outline, 38 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
