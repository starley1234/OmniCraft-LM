$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 45;             // plate width
slot_l = 24;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 41], [86, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[57, 17.5], [58.913, 17.881], [60.536, 18.964], [61.619, 20.587], [62, 22.5], [61.619, 24.413], [60.536, 26.036], [58.913, 27.119], [57, 27.5], [33, 27.5], [31.087, 27.119], [29.464, 26.036], [28.381, 24.413], [28, 22.5], [28.381, 20.587], [29.464, 18.964], [31.087, 17.881], [33, 17.5]];  // grip slot, 18 points
void_2 = [[13.527, 36.163], [12.619, 38.024], [10.902, 39.182], [8.837, 39.327], [6.976, 38.419], [5.818, 36.702], [5.673, 34.637], [6.581, 32.776], [8.298, 31.618], [10.363, 31.473], [12.224, 32.381], [13.382, 34.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[84.327, 36.163], [83.419, 38.024], [81.702, 39.182], [79.637, 39.327], [77.776, 38.419], [76.618, 36.702], [76.473, 34.637], [77.381, 32.776], [79.098, 31.618], [81.163, 31.473], [83.024, 32.381], [84.182, 34.098]];  // corner hole, 12 points
void_5 = [[84.327, 10.363], [83.419, 12.224], [81.702, 13.382], [79.637, 13.527], [77.776, 12.619], [76.618, 10.902], [76.473, 8.837], [77.381, 6.976], [79.098, 5.818], [81.163, 5.673], [83.024, 6.581], [84.182, 8.298]];  // corner hole, 12 points

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
