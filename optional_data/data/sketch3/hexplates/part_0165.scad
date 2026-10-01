$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 17.86;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[36.815, 32.485], [32.485, 36.815], [26.363, 36.815], [22.033, 32.485], [22.033, 26.363], [26.363, 22.033], [32.485, 22.033], [36.815, 26.363]];  // centre bore, 8 points
void_2 = [[49.712, 34.056], [48.089, 35.68], [45.793, 35.68], [44.169, 34.056], [44.169, 31.76], [45.793, 30.137], [48.089, 30.137], [49.712, 31.76]];  // bolt window 1, 8 points
void_3 = [[28.711, 48.089], [27.088, 49.712], [24.792, 49.712], [23.168, 48.089], [23.168, 45.793], [24.792, 44.169], [27.088, 44.169], [28.711, 45.793]];  // bolt window 2, 8 points
void_4 = [[14.679, 27.088], [13.055, 28.711], [10.759, 28.711], [9.136, 27.088], [9.136, 24.792], [10.759, 23.168], [13.055, 23.168], [14.679, 24.792]];  // bolt window 3, 8 points
void_5 = [[35.68, 13.055], [34.056, 14.679], [31.76, 14.679], [30.137, 13.055], [30.137, 10.759], [31.76, 9.136], [34.056, 9.136], [35.68, 10.759]];  // bolt window 4, 8 points

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
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_5);
}
