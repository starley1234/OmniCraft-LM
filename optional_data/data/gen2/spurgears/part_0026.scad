$fn = 32;

// ----------------------------------------------------------------------
// Spur gear: m=1.25 z=21, 28.75 mm tip diameter x 16 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
module_m = 1.25;          // module
teeth = 21;               // number of teeth
face_w = 16;              // face width
pa = 20;                  // pressure angle, deg
bore_d = 8.09;            // shaft bore
key_w = 3;                // keyway width
key_h = 1.4;              // keyway depth

/* --- involute profile --- */
pitch_r = module_m * teeth / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + module_m;
root_r = pitch_r - 1.25 * module_m;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / teeth + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / teeth + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : teeth - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / teeth)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = face_w) tooth_profile();
}

difference() {
  gear_disc();
  translate([0, 0, -1]) cylinder(h = face_w + 3, d = bore_d);
  /* keyway on the bore */
  translate([-bore_d / 2 - 1, -key_w / 2, -1]) cube([key_h + 1, key_w, face_w + 3]);
}
