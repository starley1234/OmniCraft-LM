$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 19.17;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[40.543, 37.296], [37.296, 40.543], [32.704, 40.543], [29.457, 37.296], [29.457, 32.704], [32.704, 29.457], [37.296, 29.457], [40.543, 32.704]];  // centre bore, 8 points
void_2 = [[56.48, 35.957], [55.127, 37.31], [53.213, 37.31], [51.86, 35.957], [51.86, 34.043], [53.213, 32.69], [55.127, 32.69], [56.48, 34.043]];  // bolt window 1, 8 points
void_3 = [[46.895, 52.558], [45.542, 53.911], [43.628, 53.911], [42.275, 52.558], [42.275, 50.645], [43.628, 49.292], [45.542, 49.292], [46.895, 50.645]];  // bolt window 2, 8 points
void_4 = [[27.725, 52.558], [26.372, 53.911], [24.458, 53.911], [23.105, 52.558], [23.105, 50.645], [24.458, 49.292], [26.372, 49.292], [27.725, 50.645]];  // bolt window 3, 8 points
void_5 = [[18.14, 35.957], [16.787, 37.31], [14.873, 37.31], [13.52, 35.957], [13.52, 34.043], [14.873, 32.69], [16.787, 32.69], [18.14, 34.043]];  // bolt window 4, 8 points
void_6 = [[27.725, 19.355], [26.372, 20.708], [24.458, 20.708], [23.105, 19.355], [23.105, 17.442], [24.458, 16.089], [26.372, 16.089], [27.725, 17.442]];  // bolt window 5, 8 points
void_7 = [[46.895, 19.355], [45.542, 20.708], [43.628, 20.708], [42.275, 19.355], [42.275, 17.442], [43.628, 16.089], [45.542, 16.089], [46.895, 17.442]];  // bolt window 6, 8 points

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
