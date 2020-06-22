// important for the file extension

package game;

import java.io.*;
import java.util.*;

public class GameBean implements Serializable
{
    private static final long serialVersionUID = 1L;
    
    private int roundNb;
		private int casesToOpen;
	private double cashPrize = 0;
	private boolean gameEnded = false;
	private String username = new String();
	private Briefcase[] briefcaseList;

    public GameBean() 
    {
		// Initialization of the 12 briefcases
		List<Double> values = new ArrayList<Double>(Arrays.asList(0.5,1.0,10.0,100.0,200.0,500.0,1000.0,2000.0,5000.0,10000.0,20000.0,50000.0));
		Briefcase[] briefcases = new Briefcase[values.size()];

		Collections.shuffle(values);

        for(int i = 0; i < values.size(); i++) 
        {
			briefcases[i] = new Briefcase();			
			briefcases[i].setAmount(values.get(i));
			briefcases[i].setNumber(i);
		}

		this.setBriefcaseList(briefcases);
		this.setRoundNb(1);
	}

    public String getUsername() 
    {
		return username;
	}

    public void setUsername(String username) 
    {
		this.username = username;
	}

    public Briefcase[] getBriefcaseList() 
    {
		return briefcaseList;
	}

    public void setBriefcaseList(Briefcase[] briefcaseList) 
    {
		this.briefcaseList = briefcaseList;
	}

    public int getRoundNb() 
    {
		return roundNb;
	}

    public void setRoundNb(int roundNb) 
    {

        switch(roundNb) 
        {
		    case 1:
			    this.setCasesToOpen(4);
			    break;

		    case 2:
			    this.setCasesToOpen(3);
			    break;

		    case 3:
			    this.setCasesToOpen(2);
			    break;

		    case 4:
			    this.setCasesToOpen(1);
			    break;

		    case 5:
			    this.setCasesToOpen(1);
			    break;
		}

		this.roundNb = roundNb;
	}

    public int getCasesToOpen() 
    {
		return casesToOpen;
	}

    public void setCasesToOpen(int casesToOpen) 
    {
		this.casesToOpen = casesToOpen;
	}

    public boolean isGameEnded() 
    {
		return gameEnded;
	}

    public void setGameEnded(boolean gameEnded) 
    {
		this.gameEnded = gameEnded;
	}

	public double getCashPrize() {
		return cashPrize;
	}

    public void setCashPrize(double cashPrize) 
    {
		this.cashPrize = cashPrize;
	}
}