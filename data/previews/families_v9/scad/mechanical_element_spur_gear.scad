$fn = 32;
// Spur gear, module 1.5, 25 teeth.

module_mm = 1.5;
teeth = 25;
face_w = 6;
bore_d = 6;
pitch_r = module_mm * teeth / 2;
root_r = pitch_r - 1.25 * module_mm;
tooth_t = module_mm * 1.6;

difference() {
    union() {
        cylinder(h = face_w, r = root_r);
        for (i = [0 : teeth - 1])
            rotate([0, 0, i * 360 / teeth])
                hull() {
                    translate([root_r, 0, 0])
                        cylinder(h = face_w, d = tooth_t);
                    translate([pitch_r + module_mm, 0, 0])
                        cylinder(h = face_w, d = tooth_t * 0.55);
                }
    }
    translate([0, 0, -1]) cylinder(h = face_w + 2, d = bore_d);
    translate([bore_d / 2 - 0.4, -1.5, -1])
        cube([1.8, 3.0, face_w + 2]);
}
