$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 19.17;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[40.543, 37.296], [37.296, 40.543], [32.704, 40.543], [29.457, 37.296], [29.457, 32.704], [32.704, 29.457], [37.296, 29.457], [40.543, 32.704]];  // centre bore, 8 points
void_2 = [[57.866, 36.531], [55.701, 38.696], [52.639, 38.696], [50.474, 36.531], [50.474, 33.469], [52.639, 31.304], [55.701, 31.304], [57.866, 33.469]];  // bolt window 1, 8 points
void_3 = [[38.696, 55.701], [36.531, 57.866], [33.469, 57.866], [31.304, 55.701], [31.304, 52.639], [33.469, 50.474], [36.531, 50.474], [38.696, 52.639]];  // bolt window 2, 8 points
void_4 = [[19.526, 36.531], [17.361, 38.696], [14.299, 38.696], [12.134, 36.531], [12.134, 33.469], [14.299, 31.304], [17.361, 31.304], [19.526, 33.469]];  // bolt window 3, 8 points
void_5 = [[38.696, 17.361], [36.531, 19.526], [33.469, 19.526], [31.304, 17.361], [31.304, 14.299], [33.469, 12.134], [36.531, 12.134], [38.696, 14.299]];  // bolt window 4, 8 points

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
