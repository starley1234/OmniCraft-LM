$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 45;             // plate width
slot_l = 32;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 41], [76, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[56, 17.5], [57.913, 17.881], [59.536, 18.964], [60.619, 20.587], [61, 22.5], [60.619, 24.413], [59.536, 26.036], [57.913, 27.119], [56, 27.5], [24, 27.5], [22.087, 27.119], [20.464, 26.036], [19.381, 24.413], [19, 22.5], [19.381, 20.587], [20.464, 18.964], [22.087, 17.881], [24, 17.5]];  // grip slot, 18 points
void_2 = [[13.527, 36.163], [12.619, 38.024], [10.902, 39.182], [8.837, 39.327], [6.976, 38.419], [5.818, 36.702], [5.673, 34.637], [6.581, 32.776], [8.298, 31.618], [10.363, 31.473], [12.224, 32.381], [13.382, 34.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[74.327, 36.163], [73.419, 38.024], [71.702, 39.182], [69.637, 39.327], [67.776, 38.419], [66.618, 36.702], [66.473, 34.637], [67.381, 32.776], [69.098, 31.618], [71.163, 31.473], [73.024, 32.381], [74.182, 34.098]];  // corner hole, 12 points
void_5 = [[74.327, 10.363], [73.419, 12.224], [71.702, 13.382], [69.637, 13.527], [67.776, 12.619], [66.618, 10.902], [66.473, 8.837], [67.381, 6.976], [69.098, 5.818], [71.163, 5.673], [73.024, 6.581], [74.182, 8.298]];  // corner hole, 12 points

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
