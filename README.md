Simple Quantum Computer Simulator written in Ruby by Leif-Erik Hallmann, 2022.

The program/gate configuration has to be written in a separate file (any file suffix works), which can later be executed by the main program.
The file can contain any standard ruby commands, as well as the following predetermined functions. 
Currently, only full or none entanglement are implemented, no partial entanglements.					                      
The predetermined functions for the Quantum-Circuit file are as follows:

ini_qbits(n) #Initializes a number of n qubits with the probability state of |0> = 1 (Vector: [1, 0]).

i(q) #Performs the identity matrix [[1, 0],[0, 1]] on qubit number q, practically not changing it.

x(q) #Performs the Pauli-X matrix [[0, 1],[1, 0]] on qubit number q, which flips the quantum state 180° around the X-axis.
     #The effect is like a NOT-gate.

y(q) #Performs the Pauli-Y matrix [[0, -i],[i, 0]] on qubit number q, which flips the quantum state 180° around the Y-axis.

z(q) #Performs the Pauli-Z matrix [[1, 0],[0, -1]] on qubit number q, which flips the quantum state 180° around the Z-axis.

h(q) #Performs the Hadamard matrix 1/sqrt(2)*[[1, 1],[1, -1]] on qubit number q, which puts the quantum state into superposition.

s(q) #Performs the S Phase matrix [[1, 0],[0, -i]] on qubit number q, which rotates the quantum state by 90° around the Z-axis.

sd(q) #Performs the reverse fuction of the S Phase matrix [[1, 0],[0, -i]] on qubit number q, which rotates the quantum state by -90° around the Z-axis.

t(q) #Performs the T Phase matrix [[1, 0],[0, exp(i*PI/4)]] on qubit number q, which rotates the quantum state by 45° around the Z-axis.

td(q) #Performs the reverse function of the T Phase matrix [[1, 0],[0, exp(-i*PI/4)]] on qubit number q, which rotates the quantum state by -45° around the Z-axis.

v(q) #Performs the square root function of the x-gate [[1+i, 1-i],[1-i, 1+i]]/2 on qubit number q. V*V=X 

vd(q) #Performs the negative square root function of the x-gate [[1+i, 1-i],[1-i, 1+i]]/2 on qubit number q. Vd*Vd=X; V*Vd=I

rx(theta, q) #Performs a rotation by angle theta (radians) around the X-axis on the qubit number q.

ry(theta, q) #Performs a rotation by angle theta (radians) around the Y-axis on the qubit number q.

rz(theta, q) #Performs a rotation by angle theta (radians) around the Z-Axis on the qubit number q.

All single qubit gates have a controlled multiqubit-equivalent. Just add a c in front of them like in the cx-gate example below. 
Controlled discrete angle rotations have the format (theta, c, q) in the brackets.

cx(c, q) #Performs a controlled Pauli-X or controlled-NOT on qubit number q with control qubit number c. If c is 1, q is flipped 180° around X-axis.

swp(q0, q1) #The swap gate swaps the values of qubit number q0 with the values of qubit number q1.

ccx(c0, c1, q) #The double controlled-NOT or Toffoli gate rotates the qubit number q by 180° around the X-axis, if qubit number c0 and qubit number c1 are both 1.
