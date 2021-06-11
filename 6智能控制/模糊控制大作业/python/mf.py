from mpl_toolkits.mplot3d import Axes3D  # Required for 3D plotting
import numpy as np
import skfuzzy as fuzz
import matplotlib.pyplot as plt
import skfuzzy.control as ctrl

# Generate universe variables
#   * Quality and service on subjective ranges [0, 10]
#   * Tip has a range of [0, 25] in units of percentage points
x_e = np.arange(-6, 6, 1)
x_ec = np.arange(-6, 6, 1)
x_u = np.arange(-6, 6, 1)

sigma = 1.5

# Generate fuzzy membership functions
e_nb = fuzz.gaussmf(x_e, -6, sigma)
e_nm = fuzz.gaussmf(x_e, -4, sigma)
e_ns = fuzz.gaussmf(x_e, -2, sigma)
e_no = fuzz.gaussmf(x_e, -1, sigma)

e_po = fuzz.gaussmf(x_e, 1, sigma)
e_ps = fuzz.gaussmf(x_e, 2, sigma)
e_pm = fuzz.gaussmf(x_e, 4, sigma)
e_pb = fuzz.gaussmf(x_e, 6, sigma)

# Generate fuzzy membership functions
ec_nb = fuzz.gaussmf(x_ec, -6, sigma)
ec_nm = fuzz.gaussmf(x_ec, -4, sigma)
ec_ns = fuzz.gaussmf(x_ec, -2, sigma)
ec_ze = fuzz.gaussmf(x_ec, 0, sigma)
ec_ps = fuzz.gaussmf(x_ec, 2, sigma)
ec_pm = fuzz.gaussmf(x_ec, 4, sigma)
ec_pb = fuzz.gaussmf(x_ec, 6, sigma)

# Generate fuzzy membership functions
I_nb = fuzz.gaussmf(x_u, -6, sigma)
I_nm = fuzz.gaussmf(x_u, -4, sigma)
I_ns = fuzz.gaussmf(x_u, -2, sigma)
I_ze = fuzz.gaussmf(x_u, 0, sigma)
I_ps = fuzz.gaussmf(x_u, 2, sigma)
I_pm = fuzz.gaussmf(x_u, 4, sigma)
I_pb = fuzz.gaussmf(x_u, 6, sigma)

# Visualize these universes and membership functions
fig, (ax0, ax1, ax2) = plt.subplots(nrows=3, figsize=(8, 9))

ax0.plot(x_e, e_nb, 'b', linewidth=1.5, label='NB')
ax0.plot(x_e, e_nm, 'g', linewidth=1.5, label='NM')
ax0.plot(x_e, e_ns, 'r', linewidth=1.5, label='NS')
ax0.plot(x_e, e_no, 'c', linewidth=1.5, label='NO')
ax0.plot(x_e, e_po, 'b', linewidth=1.5, label='PO')
ax0.plot(x_e, e_ps, 'y', linewidth=1.5, label='PS')
ax0.plot(x_e, e_pm, 'k', linewidth=1.5, label='PM')
ax0.plot(x_e, e_pb, 'm', linewidth=1.5, label='PB')

ax1.plot(x_ec, ec_nb, 'b', linewidth=1.5, label='NB')
ax1.plot(x_ec, ec_nm, 'g', linewidth=1.5, label='NM')
ax1.plot(x_ec, ec_ns, 'r', linewidth=1.5, label='NS')
ax1.plot(x_ec, ec_ze, 'c', linewidth=1.5, label='O')
ax1.plot(x_ec, ec_ps, 'y', linewidth=1.5, label='PS')
ax1.plot(x_ec, ec_pm, 'k', linewidth=1.5, label='PM')
ax1.plot(x_ec, ec_pb, 'm', linewidth=1.5, label='PB')

ax2.plot(x_u, I_nb, 'b', linewidth=1.5, label='NB')
ax2.plot(x_u, I_nm, 'g', linewidth=1.5, label='NM')
ax2.plot(x_u, I_ns, 'r', linewidth=1.5, label='NS')
ax2.plot(x_u, I_ze, 'c', linewidth=1.5, label='O')
ax2.plot(x_u, I_ps, 'y', linewidth=1.5, label='PS')
ax2.plot(x_u, I_pm, 'k', linewidth=1.5, label='PM')
ax2.plot(x_u, I_pb, 'm', linewidth=1.5, label='PB')

ax0.set_title('E')
ax0.legend()

ax1.set_title('EC')
ax1.legend()

ax2.set_title('I')
ax2.legend()

# Turn off top/right axes
for ax in (ax0, ax1, ax2):
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.get_xaxis().tick_bottom()
    ax.get_yaxis().tick_left()
plt.tight_layout()


plt.savefig('mf.png')


# Create the three fuzzy variables - two inputs, one output
error = ctrl.Antecedent(x_e, 'error')
delta = ctrl.Antecedent(x_ec, 'delta')
output = ctrl.Consequent(x_u, 'output')
error['nb'] = e_nb
error['nm'] = e_nm
error['ns'] = e_ns
error['no'] = e_no
error['po'] = e_po
error['ps'] = e_ps
error['pm'] = e_pm
error['pb'] = e_pb

delta['nb'] = ec_nb
delta['nm'] = ec_nm
delta['ns'] = ec_ns
delta['ze'] = ec_ze
delta['ps'] = ec_ps
delta['pm'] = ec_pm
delta['pb'] = ec_pb

output['nb'] = I_nb
output['nm'] = I_nm
output['ns'] = I_ns
output['ze'] = I_ze
output['ps'] = I_ps
output['pm'] = I_pm
output['pb'] = I_pb

system = ctrl.ControlSystem(rules=[
    ctrl.Rule(antecedent=(error['nb']|delta['nb']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['nm']|delta['nb']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['ns']|delta['nb']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['no']|delta['nb']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['po']|delta['nb']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['ps']|delta['nb']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['pm']|delta['nb']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['pb']|delta['nb']),consequent=output['ze']),

    ctrl.Rule(antecedent=(error['nb']|delta['nm']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['nm']|delta['nm']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['ns']|delta['nm']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['no']|delta['nm']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['po']|delta['nm']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['ps']|delta['nm']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['pm']|delta['nm']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['pb']|delta['nm']),consequent=output['ze']),

    ctrl.Rule(antecedent=(error['nb']|delta['ns']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['nm']|delta['ns']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['ns']|delta['ns']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['no']|delta['ns']),consequent=output['ps']),
    ctrl.Rule(antecedent=(error['po']|delta['ns']),consequent=output['ps']),
    ctrl.Rule(antecedent=(error['ps']|delta['ns']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['pm']|delta['ns']),consequent=output['nm']),
    ctrl.Rule(antecedent=(error['pb']|delta['ns']),consequent=output['nm']),

    ctrl.Rule(antecedent=(error['nb']|delta['ze']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['nm']|delta['ze']),consequent=output['pb']),
    ctrl.Rule(antecedent=(error['ns']|delta['ze']),consequent=output['ps']),
    ctrl.Rule(antecedent=(error['no']|delta['ze']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['po']|delta['ze']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['ps']|delta['ze']),consequent=output['ns']),
    ctrl.Rule(antecedent=(error['pm']|delta['ze']),consequent=output['nb']),
    ctrl.Rule(antecedent=(error['pb']|delta['ze']),consequent=output['nb']),

    ctrl.Rule(antecedent=(error['nb']|delta['ps']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['nm']|delta['ps']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['ns']|delta['ps']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['no']|delta['ps']),consequent=output['ns']),
    ctrl.Rule(antecedent=(error['po']|delta['ps']),consequent=output['ns']),
    ctrl.Rule(antecedent=(error['ps']|delta['ps']),consequent=output['nm']),
    ctrl.Rule(antecedent=(error['pm']|delta['ps']),consequent=output['nb']),
    ctrl.Rule(antecedent=(error['pb']|delta['ps']),consequent=output['nb']),

    ctrl.Rule(antecedent=(error['nb']|delta['pm']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['nm']|delta['pm']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['ns']|delta['pm']),consequent=output['ns']),
    ctrl.Rule(antecedent=(error['no']|delta['pm']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['po']|delta['pm']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['ps']|delta['pm']),consequent=output['pm']),
    ctrl.Rule(antecedent=(error['pm']|delta['pm']),consequent=output['nb']),
    ctrl.Rule(antecedent=(error['pb']|delta['pm']),consequent=output['nb']),

    ctrl.Rule(antecedent=(error['nb']|delta['pb']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['nm']|delta['pb']),consequent=output['ze']),
    ctrl.Rule(antecedent=(error['ns']|delta['pb']),consequent=output['ns']),
    ctrl.Rule(antecedent=(error['no']|delta['pb']),consequent=output['nm']),
    ctrl.Rule(antecedent=(error['po']|delta['pb']),consequent=output['nm']),
    ctrl.Rule(antecedent=(error['ps']|delta['pb']),consequent=output['nm']),
    ctrl.Rule(antecedent=(error['pm']|delta['pb']),consequent=output['nb']),
    ctrl.Rule(antecedent=(error['pb']|delta['pb']),consequent=output['nb']),
])

# Later we intend to run this system with a 21*21 set of inputs, so we allow
# that many plus one unique runs before results are flushed.
# Subsequent runs would return in 1/8 the time!
sim = ctrl.ControlSystemSimulation(system, flush_after_run=21 * 21 + 1)
"""
View the control space
----------------------

With helpful use of Matplotlib and repeated simulations, we can observe what
the entire control system surface looks like in three dimensions!
"""
# We can simulate at higher resolution with full accuracy
upsampled = np.linspace(-2, 2, 21)
x, y = np.meshgrid(upsampled, upsampled)
z = np.zeros_like(x)

# Loop through the system 21*21 times to collect the control surface
for i in range(21):
    for j in range(21):
        sim.input['error'] = x[i, j]
        sim.input['delta'] = y[i, j]
        sim.compute()
        z[i, j] = sim.output['output']

# Plot the result in pretty 3D with alpha blending

fig = plt.figure(figsize=(8, 8))
ax = fig.add_subplot(111, projection='3d')

surf = ax.plot_surface(x, y, z, rstride=1, cstride=1, cmap='viridis',
                       linewidth=0.4, antialiased=True)

cset = ax.contourf(x, y, z, zdir='z', offset=-2.5, cmap='viridis', alpha=0.5)
cset = ax.contourf(x, y, z, zdir='x', offset=3, cmap='viridis', alpha=0.5)
cset = ax.contourf(x, y, z, zdir='y', offset=3, cmap='viridis', alpha=0.5)

ax.view_init(30, 200)

plt.savefig('mfgraph.png')
