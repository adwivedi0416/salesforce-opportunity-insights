@IsTest
private class OpportunityScoreCalculatorTest {
    @IsTest
    static void testHighScoreOpportunity() {
        Opportunity opp = new Opportunity(
            Name='Big Deal - High Score',
            StageName='Negotiation/Review',
            CloseDate=Date.today().addDays(10),
            Amount=150000,
            LeadSource='Partner Referral'
        );
        insert opp;

        OpportunityScoreCalculator.ScoreResult result =
            OpportunityScoreCalculator.calculateScore(opp.Id);

        System.assertNotEquals(null, result);
        System.assert(result.score > 80);
        System.assertEquals('Low', result.riskLevel);
    }

    @IsTest
    static void testLowScoreOpportunity() {
        Opportunity opp = new Opportunity(
            Name='Small Deal - Low Score',
            StageName='Prospecting',
            CloseDate=Date.today().addDays(60),
            Amount=5000,
            LeadSource='Other'
        );
        insert opp;

        OpportunityScoreCalculator.ScoreResult result =
            OpportunityScoreCalculator.calculateScore(opp.Id);

        System.assertNotEquals(null, result);
        System.assert(result.score < 60);
        System.assertEquals('High', result.riskLevel);
    }
}