$fn = 32;

// ----------------------------------------------------------------------
// Spur gear: m=3 z=18, 60 mm tip diameter x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
modul = 3;                // module
n_teeth = 18;             // number of teeth
width = 12;               // face width
pa = 20;                  // pressure angle, deg
shaft_d = 14;             // shaft bore

/* --- involute profile --- */
pitch_r = modul * n_teeth / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + modul;
root_r = pitch_r - 1.25 * modul;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / n_teeth + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / n_teeth + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : n_teeth - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / n_teeth)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = width) tooth_profile();
}

difference() {
  gear_disc();
  translate([0, 0, -1]) cylinder(h = width + 3, d = shaft_d);
}
