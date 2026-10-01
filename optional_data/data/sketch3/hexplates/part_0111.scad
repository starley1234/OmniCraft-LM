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
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.063, 26.816], [26.816, 30.063], [22.224, 30.063], [18.977, 26.816], [18.977, 22.224], [22.224, 18.977], [26.816, 18.977], [30.063, 22.224]];  // centre bore, 8 points
void_2 = [[41.1, 28.315], [39.747, 29.668], [37.834, 29.668], [36.481, 28.315], [36.481, 26.402], [37.834, 25.049], [39.747, 25.049], [41.1, 26.402]];  // bolt window 1, 8 points
void_3 = [[31.507, 39.255], [30.154, 40.608], [28.24, 40.608], [26.887, 39.255], [26.887, 37.341], [28.24, 35.988], [30.154, 35.988], [31.507, 37.341]];  // bolt window 2, 8 points
void_4 = [[17.236, 36.416], [15.883, 37.769], [13.97, 37.769], [12.617, 36.416], [12.617, 34.503], [13.97, 33.15], [15.883, 33.15], [17.236, 34.503]];  // bolt window 3, 8 points
void_5 = [[12.559, 22.638], [11.206, 23.991], [9.293, 23.991], [7.94, 22.638], [7.94, 20.725], [9.293, 19.372], [11.206, 19.372], [12.559, 20.725]];  // bolt window 4, 8 points
void_6 = [[22.153, 11.699], [20.8, 13.052], [18.886, 13.052], [17.533, 11.699], [17.533, 9.785], [18.886, 8.432], [20.8, 8.432], [22.153, 9.785]];  // bolt window 5, 8 points
void_7 = [[36.423, 14.537], [35.07, 15.89], [33.157, 15.89], [31.804, 14.537], [31.804, 12.624], [33.157, 11.271], [35.07, 11.271], [36.423, 12.624]];  // bolt window 6, 8 points

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
