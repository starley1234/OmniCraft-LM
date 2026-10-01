$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 17.86;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[36.815, 32.485], [32.485, 36.815], [26.363, 36.815], [22.033, 32.485], [22.033, 26.363], [26.363, 22.033], [32.485, 22.033], [36.815, 26.363]];  // centre bore, 8 points
void_2 = [[49.712, 34.056], [48.089, 35.68], [45.793, 35.68], [44.169, 34.056], [44.169, 31.76], [45.793, 30.137], [48.089, 30.137], [49.712, 31.76]];  // bolt window 1, 8 points
void_3 = [[37.937, 47.484], [36.313, 49.108], [34.017, 49.108], [32.393, 47.484], [32.393, 45.188], [34.017, 43.565], [36.313, 43.565], [37.937, 45.188]];  // bolt window 2, 8 points
void_4 = [[20.42, 44], [18.796, 45.623], [16.5, 45.623], [14.876, 44], [14.876, 41.704], [16.5, 40.08], [18.796, 40.08], [20.42, 41.704]];  // bolt window 3, 8 points
void_5 = [[14.679, 27.088], [13.055, 28.711], [10.759, 28.711], [9.136, 27.088], [9.136, 24.792], [10.759, 23.168], [13.055, 23.168], [14.679, 24.792]];  // bolt window 4, 8 points
void_6 = [[26.455, 13.66], [24.831, 15.283], [22.535, 15.283], [20.911, 13.66], [20.911, 11.364], [22.535, 9.74], [24.831, 9.74], [26.455, 11.364]];  // bolt window 5, 8 points
void_7 = [[43.972, 17.144], [42.348, 18.768], [40.052, 18.768], [38.428, 17.144], [38.428, 14.848], [40.052, 13.225], [42.348, 13.225], [43.972, 14.848]];  // bolt window 6, 8 points

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
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_6);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_7);
}
