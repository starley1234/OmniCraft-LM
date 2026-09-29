$fn = 32;

// ----------------------------------------------------------------------
// Spur gear: m=1.5 z=19, 31.5 mm tip diameter x 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
gear_module = 1.5;        // module
tooth_count = 19;         // number of teeth
gear_w = 15;              // face width
pa = 20;                  // pressure angle, deg
bore = 6.35;              // shaft bore

/* --- involute profile --- */
pitch_r = gear_module * tooth_count / 2;
base_r = pitch_r * cos(pa);
tip_r = pitch_r + gear_module;
root_r = pitch_r - 1.25 * gear_module;
flank_steps = 6;

function inv_deg(a) = (tan(a) - a * PI / 180) * 180 / PI;
function flank_r(i) = root_r + (tip_r - root_r) * i / flank_steps;
function half_angle(r) = 90 / tooth_count + inv_deg(pa) - inv_deg(acos(min(1, base_r / r)));
function tooth_pt(k, i, side) =
    let (r = flank_r(i), a = k * 360 / tooth_count + side * half_angle(r))
    [r * cos(a), r * sin(a)];

module tooth_profile() {
  polygon(points = [
    for (k = [0 : tooth_count - 1])
      each [
        for (i = [0 : flank_steps]) tooth_pt(k, i, -1),
        for (i = [flank_steps : -1 : 0]) tooth_pt(k, i, 1),
        let (ta = (k + 0.5) * 360 / tooth_count)
          [root_r * cos(ta), root_r * sin(ta)]
      ]
  ]);
}

module gear_disc() {
  linear_extrude(height = gear_w) tooth_profile();
}

difference() {
  gear_disc();
  translate([0, 0, -1]) cylinder(h = gear_w + 3, d = bore);
}
