$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 45;             // plate width
slot_l = 28;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 41], [66, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[49, 18.5], [50.531, 18.804], [51.828, 19.672], [52.696, 20.969], [53, 22.5], [52.696, 24.031], [51.828, 25.328], [50.531, 26.196], [49, 26.5], [21, 26.5], [19.469, 26.196], [18.172, 25.328], [17.304, 24.031], [17, 22.5], [17.304, 20.969], [18.172, 19.672], [19.469, 18.804], [21, 18.5]];  // grip slot, 18 points
void_2 = [[13.527, 36.163], [12.619, 38.024], [10.902, 39.182], [8.837, 39.327], [6.976, 38.419], [5.818, 36.702], [5.673, 34.637], [6.581, 32.776], [8.298, 31.618], [10.363, 31.473], [12.224, 32.381], [13.382, 34.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[64.327, 36.163], [63.419, 38.024], [61.702, 39.182], [59.637, 39.327], [57.776, 38.419], [56.618, 36.702], [56.473, 34.637], [57.381, 32.776], [59.098, 31.618], [61.163, 31.473], [63.024, 32.381], [64.182, 34.098]];  // corner hole, 12 points
void_5 = [[64.327, 10.363], [63.419, 12.224], [61.702, 13.382], [59.637, 13.527], [57.776, 12.619], [56.618, 10.902], [56.473, 8.837], [57.381, 6.976], [59.098, 5.818], [61.163, 5.673], [63.024, 6.581], [64.182, 8.298]];  // corner hole, 12 points

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
