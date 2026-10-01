$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 14.55;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.543, 27.296], [27.296, 30.543], [22.704, 30.543], [19.457, 27.296], [19.457, 22.704], [22.704, 19.457], [27.296, 19.457], [30.543, 22.704]];  // centre bore, 8 points
void_2 = [[43.246, 26.531], [41.081, 28.696], [38.019, 28.696], [35.854, 26.531], [35.854, 23.469], [38.019, 21.304], [41.081, 21.304], [43.246, 23.469]];  // bolt window 1, 8 points
void_3 = [[35.971, 39.131], [33.806, 41.296], [30.744, 41.296], [28.579, 39.131], [28.579, 36.07], [30.744, 33.905], [33.806, 33.905], [35.971, 36.07]];  // bolt window 2, 8 points
void_4 = [[21.421, 39.131], [19.256, 41.296], [16.194, 41.296], [14.029, 39.131], [14.029, 36.07], [16.194, 33.905], [19.256, 33.905], [21.421, 36.07]];  // bolt window 3, 8 points
void_5 = [[14.146, 26.531], [11.981, 28.696], [8.919, 28.696], [6.754, 26.531], [6.754, 23.469], [8.919, 21.304], [11.981, 21.304], [14.146, 23.469]];  // bolt window 4, 8 points
void_6 = [[21.421, 13.93], [19.256, 16.095], [16.194, 16.095], [14.029, 13.93], [14.029, 10.869], [16.194, 8.704], [19.256, 8.704], [21.421, 10.869]];  // bolt window 5, 8 points
void_7 = [[35.971, 13.93], [33.806, 16.095], [30.744, 16.095], [28.579, 13.93], [28.579, 10.869], [30.744, 8.704], [33.806, 8.704], [35.971, 10.869]];  // bolt window 6, 8 points

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
