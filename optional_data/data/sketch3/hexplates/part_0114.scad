$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 29.44;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[45.543, 36.937], [42.296, 40.184], [37.704, 40.184], [34.457, 36.937], [34.457, 32.345], [37.704, 29.098], [42.296, 29.098], [45.543, 32.345]];  // centre bore, 8 points
void_2 = [[73.136, 36.172], [70.971, 38.337], [67.909, 38.337], [65.744, 36.172], [65.744, 33.11], [67.909, 30.945], [70.971, 30.945], [73.136, 33.11]];  // bolt window 1, 8 points
void_3 = [[58.416, 61.668], [56.251, 63.832], [53.189, 63.832], [51.024, 61.668], [51.024, 58.606], [53.189, 56.441], [56.251, 56.441], [58.416, 58.606]];  // bolt window 2, 8 points
void_4 = [[28.976, 61.668], [26.811, 63.832], [23.749, 63.832], [21.584, 61.668], [21.584, 58.606], [23.749, 56.441], [26.811, 56.441], [28.976, 58.606]];  // bolt window 3, 8 points
void_5 = [[14.256, 36.172], [12.091, 38.337], [9.029, 38.337], [6.864, 36.172], [6.864, 33.11], [9.029, 30.945], [12.091, 30.945], [14.256, 33.11]];  // bolt window 4, 8 points
void_6 = [[28.976, 10.676], [26.811, 12.841], [23.749, 12.841], [21.584, 10.676], [21.584, 7.614], [23.749, 5.45], [26.811, 5.45], [28.976, 7.614]];  // bolt window 5, 8 points
void_7 = [[58.416, 10.676], [56.251, 12.841], [53.189, 12.841], [51.024, 10.676], [51.024, 7.614], [53.189, 5.45], [56.251, 5.45], [58.416, 7.614]];  // bolt window 6, 8 points

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
