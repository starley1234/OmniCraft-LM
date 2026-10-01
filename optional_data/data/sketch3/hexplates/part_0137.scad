$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 17.86;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[36.815, 32.485], [32.485, 36.815], [26.363, 36.815], [22.033, 32.485], [22.033, 26.363], [26.363, 22.033], [32.485, 22.033], [36.815, 26.363]];  // centre bore, 8 points
void_2 = [[49.251, 33.865], [47.898, 35.218], [45.984, 35.218], [44.631, 33.865], [44.631, 31.952], [45.984, 30.599], [47.898, 30.599], [49.251, 31.952]];  // bolt window 1, 8 points
void_3 = [[19.958, 43.809], [18.605, 45.162], [16.691, 45.162], [15.338, 43.809], [15.338, 41.895], [16.691, 40.542], [18.605, 40.542], [19.958, 41.895]];  // bolt window 2, 8 points
void_4 = [[25.993, 13.469], [24.64, 14.822], [22.726, 14.822], [21.373, 13.469], [21.373, 11.555], [22.726, 10.202], [24.64, 10.202], [25.993, 11.555]];  // bolt window 3, 8 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
