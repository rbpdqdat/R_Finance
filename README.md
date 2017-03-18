# R_Finance

# Loan Assessment Tool

This simple tool is just the beginning of a more extensive financial assessment application.

The user will provide inputs:

1) Term of Loan (months) - How long the payback period will be
2) Annual Percentage Rate (Floating number; increment 1/8 %)- The interest on the loan amount
3) Loan Amount (U.S. Dollars) - The initial loan amount
4) (optional) - Additional monthly payments (in U.S. Dollars)

The user needs to hit the submit button for the server to calculate and return several items.

The server then returns the following:

- Initial Loan Amount (Original Principal)
- Monthly payments
- Total payback amount for the life of the loan

The last value returned will be zero zero is the 'Extra Monthly $' is left at zero.
If the 'Extra Monthly $' is filled in the following will display:

- the amount saved (interest saved in $) by paying extra and the number of months the term is reduced

The graph displays only the amount of principal remaining during the life of the loan excluding any additional payments (red).
The green line indicates the amount paid on the load through the life of the loan.

[Link to Shinyapp](https://rbigley.shinyapps.io/R_Finance/)

# Additional Work

The app is expected to undergo additional development.  To determine if extra $ should be invested into the load payment, or if it might be a better strategy to put that money into an investement account.
The differences in the strategies will create financial guidance.  Another factor that will be included is the equity that could be tapped into if the asset that is the basis of the loan grows/shrinks in value.
This could be the basis for financial risk strategies when a series of random walk assigments are used.


